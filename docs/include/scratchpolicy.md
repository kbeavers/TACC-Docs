### [Scratch File System Purge Policy](#scratchpolicy)

<p class="portlet-msg-info">The <code>$SCRATCH</code> file system, as its name indicates, is a temporary storage space.  Files that have not been accessed&#42; in ten days are subject to purge.  Deliberately modifying file access time (using any method, tool, or program) for the purpose of circumventing purge policies is prohibited.</p>

&#42;The operating system updates a file's access time when that file is modified on a login or compute node or any time that file is read. Reading or executing a file/script will update the access time.  Use the NOWRAP"`ls -ul`"ESPAN command to view access times.

