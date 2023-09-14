# a few things interact to require this:
# * spinnaker validations require _a lot_ of open files/filehandles.
# * the default soft limit is ... 256?
# * docker seems to not reclaim them when a container exits (but re-uses them when you run another?).
# addressing this is

ulimit -Sn 1048576  # :one-million-dollars:
