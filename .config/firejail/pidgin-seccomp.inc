seccomp.block-secondary

seccomp.keep restart_syscall,unshare,exit_group,exit,getpid,getpgrp,getsockopt,setsockopt,umask,shutdown,clock_gettime,rt_sigreturn,getrusage,tgkill,access,arch_prctl,brk,chmod,clock_getres,clone,close,connect,dup,dup2,eventfd2,execve,fadvise64,fcntl,fstat,fstatfs,fsync,ftruncate,futex,getcwd,getdents,getegid,geteuid,getgid,getpeername,getppid,getresgid,getresuid,getrlimit,getsockname,gettid,getuid,inotify_add_watch,inotify_init1,ioctl,kill,lseek,lstat,madvise,mkdir,mmap,mprotect,mremap,munmap,nanosleep,open,openat,pipe,pipe2,poll,ppoll,prctl,read,readlink,recvfrom,recvmsg,rename,rt_sigaction,rt_sigprocmask,select,sendmmsg,sendmsg,sendto,set_robust_list,set_tid_address,shmat,shmctl,shmdt,shmget,socket,socketpair,stat,statfs,sysinfo,uname,unlink,wait4,write,writev,prlimit64,getrandom,flock,pread64,fchmod,alarm,pwrite64