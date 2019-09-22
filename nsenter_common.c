#define _GNU_SOURCE
#include <fcntl.h>
#include <sched.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

#define errExit(msg)    do { perror(msg); exit(EXIT_FAILURE); \
                        } while (0)

int
main(int argc, char *argv[])
{
	int fd;
	uid_t ruid, euid, suid;
	//int uid = getuid();
	getresuid(&ruid, &euid, &suid);
    	printf("My UID is: %d. My EUID is: %d. My SUID: %d\n", ruid, euid, suid);
	fflush( stdout );
	if (argc < 3) {
		fprintf(stderr, "%s /proc/PID/ns/FILE cmd args...\n", argv[0]);
		exit(EXIT_FAILURE);
	}
	
	if (setuid(0))
	{
		errExit("setuiderror");
	}

	fd = open(argv[1], O_RDONLY); /* Get file descriptor for namespace */
	if (fd == -1)
		errExit("fileopenerror");

	if (setns(fd, CLONE_NEWNET) == -1)       /* Join that namespace */
		errExit("setnserror");
	
	if (setuid(ruid))
	{
		errExit("undo_setuiderror");
	}
	execvp(argv[2], &argv[2]);    /* Execute a command in namespace */
	close(fd);
	errExit("execvp");
}
