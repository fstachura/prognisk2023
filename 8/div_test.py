import random
import subprocess

while True:
    proc = subprocess.Popen("./z3", stdin=subprocess.PIPE, stdout=subprocess.PIPE)

    l = random.randint(1, 5)
    nums = [random.randint(0, 0xffff_ffff) if random.randint(0, 2) == 1 else 0 for _ in range(l)]
    div = random.randint(1, 0xffff_ffff)

    (stdout, stderr) = proc.communicate(
        str(l).encode("ascii") + b"\n" +
        b"".join([str(n).encode("ascii") + b" " for n in nums]) + b"\n" +
        str(div).encode("ascii")
    )

    print(l)
    print(" ".join([str(n) for n in nums]))
    print(div)

    if proc.returncode == 0:
        [mod_result, nums_result, _] = stdout.split(b"\n")
        s = nums_result.split(b" ")[:-1]
        print()
        print("result:")
        for n in s: print(n.decode("ascii"), end=" ")
        print()
        print(mod_result.decode("ascii"))

        print()
        print("actual:")
        real = 0
        for n in nums:
            real <<= 32
            real |= n
        #print(hex(real))
        print(hex(real//div))
        print(hex(real%div))

        if real%div != int(mod_result.decode("ascii"), 16):
            print("invalid mod")
            exit(-1)

        received = 0
        for n in s:
            received <<= 32
            received |= int(n.decode("ascii"), 16)

        if real//div != received:
            print("invalid div")
            exit(-1)
        
    else:
        print("error")
        exit(-1)

