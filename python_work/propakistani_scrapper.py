from itertools import count
import os
import re
import requests
import codecs

#functions

# def make_txt_file(para1):                         # legacy
#  with open('category/'+para1, mode='w') as f:
#    print('',file=f)
#    f.close()


def append_value(para1,para2):
 with open(para1, mode="a") as file_object:
  file_object.write(para2)
  file_object.close()

def  request_base_url():
 b=('https://propakistani.pk/index.html')
 c=requests.get(b).text
 return c

def  request_category_urls(x):
 b=('https://propakistani.pk'+x)
 #print(b)
 c = requests.get(b)
 d = c.text
 return d

#a=request_base_url()           #uncomment after done
#append_value('index.html',a)
def open_utf(a):
 b=codecs.open(a, "r", "utf-8")
 c=b.read()
 return c

f=open_utf('index.html')
list_1=[]

# pattern=re.compile(r'(?<=<li class="cat-item cat-item-)(.*)(?=/a>)') legacy
# for match in pattern.finditer(f):
#     g=match.group(1) # need to append in a list for later use
#     h=g.splitlines() #Do this long process due to group (g) is not iterable directly make it lists and grep by list indexes
#     for k in h:
#       l=re.sub('(?<=(\d))(.*)(?=.pk/)',"",k) #Do this due to Decimal Value has random length 
#       list_1.append(l)

#-----operations to get desired list

list_2=[] #stored content for making files      
m=set(list_1)
for index in m:
 n=index[4:]
 o=re.split("\"",n)
 p=(o[0])
 list_2.append(p)

print(type(list_2))
list_3=[] #list 3 store items for making urls sample item : /category/others/govenment/ 

main_dir='category'
try:
  if os.path.isdir(main_dir): 
   pass
  else:
     os.mkdir(main_dir)  #not found python mkdir tools except in os library to make os independent library 
except Exception as e:
     print(e)


list_4=[] # make txt and items to be scrap
for i in list_2:
 list_3.append(i) #append in a list for
 a=i.replace('/category/','')
 b=re.split('/',a) 
 for j in b:
  if not j:
   continue
  else:
   list_4.append(j)


# for i in list_3:              #uncomment after done
#  a=request_category_urls(i)
#  for j in list_4:  
#   append_value(j+'.html',a) 


list_6=[]
for b in list_4:
 a=open_utf(b+'.html')
 pattern=re.compile(r'(?<=<h2)(.*)(?=</a></h2>)')
 for match in pattern.finditer(a):
    g=match.group(1) # need to append in a list for later use
    pattern_1=re.compile(r'(?<=rel="bookmark">)(.*)(?=)')
    for match in pattern_1.finditer(g):
     g=match.group(1) # need to append in a list for later use
     a=g.splitlines()
     if b==b:
      list_6.append(a)
      count=0    
      for i in list_6: 
       count=count+1    #  for i in a: 
       l="{line_number}: {post}\n".format(line_number=count, post=i)
       append_value('category/'+b+'.txt',l)



#   for p in a:
#   scrap(p)

#      k=h.splitlines()
#      for j in k:
#        count=0
#        list_6.append(j)
#     for ln in list_6:
#          
     