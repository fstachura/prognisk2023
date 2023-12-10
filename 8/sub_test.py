import random
import subprocess

while True:
    proc = subprocess.Popen("./z3", stdin=subprocess.PIPE, stdout=subprocess.PIPE)

    a_len = random.randint(1, 5)
    a_nums = [random.randint(0, 0xffff_ffff) if random.randint(0, 10) != 4 else 0 for _ in range(a_len)]
    b_len = random.randint(1, 5)
    b_nums = [random.randint(0, 0xffff_ffff) if random.randint(0, 10) != 4 else 0 for _ in range(b_len)]

    (stdout, stderr) = proc.communicate(
        str(a_len).encode("ascii") + b"\n" +
        b"".join([str(n).encode("ascii") + b" " for n in a_nums]) + b"\n" +
        str(b_len).encode("ascii") + b"\n" +
        b"".join([str(n).encode("ascii") + b" " for n in b_nums]) + b"\n"
    )

    print(a_len)
    for n in a_nums: print(n, end=" ")
    print()
    print(b_len)
    for n in b_nums: print(n, end=" ")
    print()

    def convert(nums):
        real = 0
        for n in nums:
            real <<= 32
            real |= n
        return real

    if proc.returncode == 0:
        [add_result, _] = stdout.split(b"\n")
        result_nums = add_result.split(b" ")[:-1]
        print()
        print("result:")
        for n in result_nums: print(n.decode("ascii"), end=" ")
        print()

        print()
        print("actual:")
        actual = abs(convert(a_nums) - convert(b_nums))
        print(hex(actual))

        received = convert([int(n.decode("ascii"), 16) for n in result_nums])

        if actual != received:
            print("invalid result")
            exit(-1)

    else:
        print("error")
        exit(-1)


