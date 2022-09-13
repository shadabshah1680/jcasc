# %%
a=[('shadab',1),('khawar',2),('ali',3),('asad',4)]
b=[]
c=[]

# %%
for i   in a:
    b.append(i[0])
    c.append(i[1])

# %%
print(b)
print(c)

# %%
d=[index for index, item in enumerate(c) if item == max(c)][0]

# %%
e=b[d]
f=c[d]
print(d)

# %%
g=[]
g.append(e)
g.append(f)
print(tuple(g))

# %%



