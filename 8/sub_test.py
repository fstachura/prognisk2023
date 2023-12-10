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
        for n in result_nums: print(n.decode("ascii").ljust(8, "0"), end=" ")
        print()

        print()
        print("actual:")
        actual_num = convert(a_nums) - convert(b_nums)
        actual = hex(abs(actual_num))[2:]
        actual.ljust((len(actual)//8)*8, "0")
        for i in range(0, len(actual), 8): print(actual[i:i+8], end=" ")
        print()

        received = convert([int(n.decode("ascii"), 16) for n in result_nums])

        if abs(actual_num) != received:
            for n in a_nums: print(hex(n), end=" ")
            print()
            for n in b_nums: print(hex(n), end=" ")
            print()
            print(hex(convert(a_nums)), hex(convert(b_nums)))
            print(hex(actual_num))
            print(hex(received))
            a = a_nums
            b = b_nums
            if len(b_nums) > len(a_nums): 
                a, b = b, a
            for i in range(len(b)):
                print(a > b, end=" ")

            print()
            print("invalid result")
            exit(-1)

    else:
        print("error")
        exit(-1)


