#!/usr/bin/env bash

build/rv32emu --gdbstub build/puzzle.elf &
PID=$!

# Before starting GDB, we should ensure rv32emu is still running.
if ps -p $PID > /dev/null
then
    tmpfile=/tmp/rv32emu-gdbstub.$PID
    riscv32-unknown-elf-gdb --batch -x tests/gdbstub/remote-commands.gdb > ${tmpfile}

    # check if we stop at the breakpoint
    expected=$(grep -rw "Breakpoint 1 at" ${tmpfile} | awk {'print $4'})
    ans=$(grep -r "$1 =" ${tmpfile} | awk {'print $5'})
    if [ "$expected" != "$ans" ]; then
        # Fail
        exit 1
    fi
    # Pass and wait
    exit 0
    wait $PID
fi

exit 1