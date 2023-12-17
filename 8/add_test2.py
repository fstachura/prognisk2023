import random
import subprocess

while True:
    proc = subprocess.Popen("./z3", stdin=subprocess.PIPE, stdout=subprocess.PIPE)

    a = random.randint(0, 2**128)
    b = random.randint(0, 2**128)
    result = a + b

    (stdout, stderr) = proc.communicate(
        str(a).encode("ascii") + b"\n" +
        str(b).encode("ascii") + b"\n"
    )

    print(a)
    print(b)

    if proc.returncode == 0:
        [add_result, _] = stdout.split(b"\n")

        actual = a+b
        received = int(add_result)

        if actual != received:
            print("invalid result")
            exit(-1)

    else:
        print("error")
        exit(-1)


