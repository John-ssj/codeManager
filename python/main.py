# import base64
#
# f = open('/Users/apple/Downloads/10_million_password_list_top_100.txt', 'r')
# spring = open('/Users/apple/Downloads/output.txt', 'w')
# lines = f.readlines()
#
# for line in lines:
#     Authorization = "admin:"+line.strip('\n')
#     Authorizationbs64 = base64.b64encode(Authorization.encode("utf-8"))
#     print(str(Authorizationbs64, 'utf-8'))
#     spring.write(str(Authorizationbs64, 'utf-8'))
#     spring.write("\n")
#
# f.close()
# spring.close()
#

a = ''
for t in range(1, 26):
    a = ''
    for i in 'OMQEMDUEQMEK':
        a += (chr(ord(i)+t-26) if chr(ord(i)+t) > 'Z' else chr(ord(i)+t))
    print(a)

# BOIHGKNQVTWYURXZAJEMSLDFPC

dic = {}
for i in '"Frequency Analysis" is your friend.':
    if i in dic.keys():
        dic[i] += 1
    else:
        dic[i] = 1

print(sorted(dic.items(), key=lambda d: (d[1], d[0]), reverse=True))
