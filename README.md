# hashdist-dealiisuite
deal.ii suite on hashdist


## mpiexec
in order to run deal.II unit tests with Intel MPI one may need to create an alias:
```
touch mpiexec

# put the following to the file (adjust path to mpiexec as needed):

#!/bin/bash
mpiexec.hydra "$@"

# make the file executable:
chmod +x mpiexec

# make sure mpiexec is in PATH
```