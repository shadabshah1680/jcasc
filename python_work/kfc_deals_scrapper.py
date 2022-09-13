import re
import requests

#functions

def make_txt_file(para1):
 with open(para1, mode='w') as f:
   print('',file=f)
   f.close()

def append_value(para1,para2):
 with open(para1, mode="a") as file_object:
  file_object.write(para2)
  file_object.close()



x = requests.get('https://www.kfcpakistan.com/index.html')
a=(x.text)
match = re.search('</app-root><script(.*)</script></body></html>', a)
b= match.group(1) if match else None
c=b.split('\\&q;')

d='/collection/'
j='/product/'


# for i in c:
#  if d in i:
#   e=i.replace(d,"")
#   k=(e.capitalize()+".txt")
#   make_txt_file(k)
#   while i:
#    if j in i:
#     l=i.replace(j,"")
#     m=l.capitalize()
#     append_value(k,m)
#    if d==i:
#      break
import re
import requests
import codecs
#functions

def make_txt_file(para1):
 with open(para1, mode='w') as f:
   print('',file=f)
   f.close()

def append_value(para1,para2):
 with open(para1, mode="a") as file_object:
  file_object.write(para2)
  file_object.close()


def  request_urls(x):
 b=('https://propakistani.pk/'+x+'index.html')
 print(b)
 c = requests.get(b)
 d = c.text()
 return d

# a=request_urls('')
# append_value('index.html',a)
e= codecs.open("index.html", "r", "utf-8")
f=e.read()
pattern=re.compile(r'(?<=<li class="cat-item cat-item-)(.*)(?=/a>)')
for match in pattern.finditer(f):
    g=match.group()

print(g)

# print(h)
d='/collection/'
j='/product/'


# for i in c:
#  if d in i:
#   e=i.replace(d,"")
#   k=(e.capitalize()+".txt")
#   make_txt_file(k)
#   while i:
#    if j in i:
#     l=i.replace(j,"")
#     m=l.capitalize()
#     append_value(k,m)
#    if d==i:
#      break