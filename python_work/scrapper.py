#built-in libraries
import io
import os
import re
from time import sleep
import requests

#functions

def delete_html(h):
 try:
    #make sure file is clean
  if os.path.exists(h+'.html'):
   os.remove(h+'.html')
  else:
   print("Cleaning existing files") 
 except Exception as e:
  
  return e

def delete_txt(h):
 try:
    #make sure file is clean
  if os.path.exists('category/'+h+'.txt'):
   os.remove('category/'+h+'.txt')
  else:
   print("Cleaning existing files") 
 except Exception as e:
  
  return e


def append_value(para1,para2):
 with open(para1, mode="a") as file_object:
  file_object.write(para2)
  file_object.close()

def  request_base_url():
 b=('https://propakistani.pk')
 c=requests.get(b)
 c=c.text 
 return c

def  request_category_urls(x):
 b=('https://propakistani.pk'+x)
 c = requests.get(b)
 d = c.text
 return d

z='index'
w=delete_html(z)
print(w)


a=request_base_url()           #remove comment after_done
append_value('index.html',a)

def open_utf(a):
  a=io.open(a, mode="r" ,encoding="UTF-8")
  a=a.read()
  return a

myindexfile='index.html'

f=open_utf(myindexfile)
print(type(f))
print(f)
f=str(f)
list_0=[]
pattern=re.compile(r'(?<=<li class="cat-item cat-item-)(.*)(?=/a>)') #legacy
for match in pattern.finditer(f):
    g=match.group(1) # need to append in a list for later use
    h=g.splitlines() #Do this long process due to group (g) is not iterable directly make it lists and grep by list indexes
    for k in h:
      l=re.sub('(?<=(\d))(.*)(?=.pk/)',"",k) #Do this due to Decimal Value has random length 
      list_0.append(l)

# pattern=re.findall('(?<=<a href="https://propakistani.pk/category/)(.*)(?=/">)',f) 
# a=str(pattern)
# b=a.replace('><',',')
# op=b.split(',')
# for i in op:
#    if '/category/' in i:
#      l=re.sub('^(.*).pk(?=/)',"",i)
#      m=re.sub('(?<=/")(.*)','',l)
#      g=m.replace("\"","")
#      list_0.append(g)               #sample-data ['/category/automobile/', '/category/business/']


list_0=set(list_0)
list_0=list(list_0)
print(type(list_0))
print(list_0)


#-----------------legacy-work--------------------------

# pattern=re.compile(r'(?<=<a href="https://propakistani.pk/category/)(.*)(?=</a></li>)')   #legacy
# for match in pattern.finditer(i):
#     g=match.group(1) # need to append in a list for later use
#     h=g.splitlines() #Do this long process due to group (g) is not iterable directly make it lists and grep by list indexes
#     for k in h:
#       l=re.sub('(?<=(\d))(.*)(?=.pk/)',"",k) #Do this due to Decimal Value has random length 
#       print(l)
#       list_1.append(l)

#-----------------operations to get desired list--------------#legacy

list_1=[] #stored content for making dir,files & append values in it                  #legacy
for index in list_0:
 a=i.rsplit('/', 3)[-2]
 list_1.append(a)


print(list_1)

#--------------------making drectory to append txts
main_dir='category'
try:
  if os.path.isdir(main_dir): 
   pass
  else:
     os.mkdir(main_dir)  #not found python mkdir tools except in os library to make os independent library 
except Exception as e:
     print(e)


#-----------------deleting existing txt's--------------

for i in list_1: 
  delete_txt('category/'+i)

#------------------cleaning existing files---------------

for i in list_1:    #clean_existing_files
  delete_html(i)
  
#------------------Requesting urls and save it to file----

for i in list_0:              #uncomment after done
 a=request_category_urls(i)
 print('Rquesting Url......')
 sleep(1)
 j=i.rsplit('/', 3)[-2]
 append_value(j+'.html',a)

#------------------data-cleaning-operation----------
for b in list_1:
 a=open_utf(b+'.html') #picking regarded html
 a=str(a)
 pattern=re.findall(r'(?<=<h2)(.*)(?=</a></h2>)',a)
 pattern1=pattern[0]
 g=re.sub('(?<=<a href=\")',",",pattern1)
 h=g.split(',')
 for i in h:
  if 'rel="bookmark">' in i:
    pattern=re.compile(r'(?<=rel="bookmark">)(.*)(?=</a></h2>)')
    count=0
    for match in pattern.finditer(i):
     c=match.group(1) #c contain some special strings to remove this i used if 
     if len(c) > 100:
      print('')
     else:
      count=count+1
      #l="{line_number}: {post}\n".format(line_number=count, post=c)
      append_value('category'+b+'.txt',c)

# #------------------append_line_number-------------------

for i in list_1:
 j='category/'+i+'.txt'
 os.system("echo '1,$n' | ed -s ${j} > ${j}")

#------------------cleaning_workspace--------------------


for i in list_1:    #clean_existing_files
  delete_html(i)
