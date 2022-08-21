def gcd(a, b):
  return b if a % b == 0 else gcd(b, a % b)

def exercise_12_2(N, g, r):
  assert g ** r % N == 1
  if r % 2 == 1:
    print('Period is odd')
  else:
    x1 = g ** (r // 2) % N - 1
    x2 = g ** (r // 2) % N + 1
    f1 = gcd(x1, N)
    f2 = gcd(x2, N)
    print(f'gcd({x1}, {N}) == {f1}, gcd({x2}, {N}) == {f2}')
    assert f1 != 1 or f2 != 1

exercise_12_2(N=35, g=17, r=12)
exercise_12_2(N=143, g=19, r=60)
