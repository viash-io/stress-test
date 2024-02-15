# stress-test


This pipeline is used to stress test the Nextflow execution engine. It
runs a series of tasks that consume a large amount of memory, disk
space, and time to see which exit codes are returned.

## Stress test code

Build components

``` bash
viash ns build --setup cb
```

    Exporting stress =docker=> target/docker/stress
    [notice] Building container 'stress:latest' with Dockerfile
    Exporting stress =nextflow=> target/nextflow/stress
    All 2 configs built successfully

Clean up previous runs

Create a parameter file

``` bash
cat > /tmp/params.yaml <<EOF
param_list:
  - id: memory
    mode: memory
  - id: time
    mode: time
  - id: disk
    mode: disk
EOF
```

Run the pipeline

``` bash
nextflow run target/nextflow/stress/main.nf \
  -profile docker,no_publish \
  -params-file /tmp/params.yaml \
  -with-trace trace.log
```

    [33mNextflow 23.10.1 is available - Please consider updating your version to it(B[m
    N E X T F L O W  ~  version 23.10.0
    Launching `target/nextflow/stress/main.nf` [serene_meitner] DSL2 - revision: d1f6970f79
    [-        ] process > stress:processWf:stress_process -

    executor >  local (3)
    [a2/d1c284] process > stress:processWf:stress_process (memory)       [  0%] 0 of 3
    [-        ] process > stress:publishStatesSimpleWf:publishStatesProc -

    executor >  local (3)
    [a2/d1c284] process > stress:processWf:stress_process (memory)       [  0%] 0 of 3
    [-        ] process > stress:publishStatesSimpleWf:publishStatesProc -

    executor >  local (3)
    [ab/b23e68] process > stress:processWf:stress_process (disk)         [ 33%] 1 of 3, failed: 1
    [-        ] process > stress:publishStatesSimpleWf:publishStatesProc -
    [ab/b23e68] NOTE: Process `stress:processWf:stress_process (disk)` terminated with an error exit status (137) -- Error is ignored

    executor >  local (3)
    [a2/d1c284] process > stress:processWf:stress_process (memory)       [ 66%] 2 of 3, failed: 2
    [-        ] process > stress:publishStatesSimpleWf:publishStatesProc -
    [ab/b23e68] NOTE: Process `stress:processWf:stress_process (disk)` terminated with an error exit status (137) -- Error is ignored
    [a2/d1c284] NOTE: Process `stress:processWf:stress_process (memory)` terminated with an error exit status (137) -- Error is ignored

    executor >  local (3)
    [92/968e8f] process > stress:processWf:stress_process (time)         [100%] 3 of 3, failed: 3 ✔
    [-        ] process > stress:publishStatesSimpleWf:publishStatesProc -
    [ab/b23e68] NOTE: Process `stress:processWf:stress_process (disk)` terminated with an error exit status (137) -- Error is ignored
    [a2/d1c284] NOTE: Process `stress:processWf:stress_process (memory)` terminated with an error exit status (137) -- Error is ignored
    [92/968e8f] NOTE: Process `stress:processWf:stress_process (time)` failed -- Error is ignored

    executor >  local (3)
    [92/968e8f] process > stress:processWf:stress_process (time)         [100%] 3 of 3, failed: 3 ✔
    [-        ] process > stress:publishStatesSimpleWf:publishStatesProc -
    [ab/b23e68] NOTE: Process `stress:processWf:stress_process (disk)` terminated with an error exit status (137) -- Error is ignored
    [a2/d1c284] NOTE: Process `stress:processWf:stress_process (memory)` terminated with an error exit status (137) -- Error is ignored
    [92/968e8f] NOTE: Process `stress:processWf:stress_process (time)` failed -- Error is ignored

## Check outputs

### Run work/92/968e8f4b275eaa2bf5239d766627ed

Exit code: 143

Log:

    Time stress test
    stress-ng: info:  [142] setting to a 1 min, 0 secs run per stressor
    stress-ng: info:  [142] dispatching hogs: 1 matrix

### Run work/a2/d1c284954b6c50d1edf831470090e7

Exit code: 137

Log:

    Memory stress test
    stress-ng: info:  [111] defaulting to a 1 day, 0 secs run per stressor
    stress-ng: info:  [111] dispatching hogs: 1 atomic, 1 bad-altstack, 1 bsearch, 1 context, 1 full, 1 heapsort, 1 hsearch, 1 judy, 1 list, 1 lockbus, 1 lsearch, 1 malloc, 1 matrix, 1 matrix-3d, 1 mcontend, 1 membarrier, 1 memcpy, 1 memfd, 1 memrate, 1 memthrash, 1 mergesort, 1 mincore, 1 misaligned, 1 null, 1 numa, 1 pipe, 1 pipeherd, 1 prefetch, 1 qsort, 1 radixsort, 1 randlist, 1 remap, 1 resources, 1 rmap, 1 shellsort, 1 skiplist, 1 sparsematrix, 1 stack, 1 stackmmap, 1 str, 1 stream, 1 tlb-shootdown, 1 tmpfs, 1 tree, 1 tsearch, 1 vm, 1 vm-addr, 1 vm-rw, 1 vm-segv, 1 wcs, 1 zero, 1 zlib
    stress-ng: info:  [115] context: this stressor is not implemented on this system: x86_64 Linux 6.7.4-200.fc39.x86_64 musl-gcc 13.2.1 (built without ucontext.h)
    stress-ng: info:  [136] memrate: using buffer size of 262144K, cache flushing disabled
    stress-ng: info:  [136] memrate: cache flushing can be enabled with --memrate-flush option
    stress-ng: info:  [142] mincore: this stressor is not implemented on this system: x86_64 Linux 6.7.4-200.fc39.x86_64 musl-gcc 13.2.1 (built without mincore() system call support)
    stress-ng: info:  [147] numa: system has 1 of a maximum 1024 memory NUMA nodes
    stress-ng: fail:  [147] numa: get_mempolicy failed, errno=1 (Operation not permitted)
    stress-ng: info:  [146] null: exercising /dev/null with writes, lseek, ioctl, fcntl, fallocate and fdatasync; for just write benchmarking use --null-write
    stress-ng: info:  [143] misaligned: skipping method int128rd, misaligned operations tripped signal 11 'SIGSEGV'
    stress-ng: info:  [139] memthrash: starting 32 threads on each of the 1 stressors on a 32 CPU system
    stress-ng: warn:  [139] memthrash: WARNING: finished prematurely after just 0.54 secs
    stress-ng: info:  [181] sparsematrix: 10000 items in 500 x 500 sparse matrix (4.00% full)
    stress-ng: info:  [186] stackmmap: this stressor is not implemented on this system: x86_64 Linux 6.7.4-200.fc39.x86_64 musl-gcc 13.2.1 (built without ucontext.h or swapcontext())
    stress-ng: info:  [151] qsort: using method 'qsort-libc'
    stress-ng: error: [197] tmpfs: cannot find writeable free space on a tmpfs filesystem
    stress-ng: info:  [243] zero: exercising /dev/zero with reads, mmap, lseek, and ioctl; for just read benchmarking use --zero-read

### Run work/ab/b23e686f636073baa33e7841ee60c6

Exit code: 137

Log:

    Disk stress test
