#built-in libraries
import codecs
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
   print("File Not Found") 
 except Exception as e:
  
  return e

def delete_txt(h):
 try:
    #make sure file is clean
  if os.path.exists('category/'+h+'.txt'):
   os.remove('category/'+h+'.txt')
  else:
   print("File Not Found") 
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

delete_html('index')


a=request_base_url()           #remove comment after_done
append_value('index.html',a)
sleep(5)

def open_utf(a):
  a=codecs.open(a, mode="r" ,encoding="UTF-8")
  a=a.read()
  return a

myindexfile='index.html'

f=open_utf(myindexfile)
sleep(1)
print(type(f))
f=str(f)

list_0=[]

pattern=re.findall('(?<=<a href="https://propakistani.pk/category/)(.*)(?=/">)',f) 

list_0=pattern
print(list_0)
#-----------------operations to get desired list--------------#legacy

list_1=[] #stored content for making dir,files & append values in it                  #legacy
for index in list_0:
 a=index.replace("/","\n")
 print(a)
 list_1.append(a)


print(list_1)

list_2=[]

for index in list_0:
 a='/category/'+index+'/'
 list_2.append(a)

print(list_2)   #['/category/sample/data/']
#--------------------making drectory to append txts---------------
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
  try:   
    delete_txt('category/'+i+'.txt')
  except:
    print('Unable to delete txt Cuz File not found')
#------------------cleaning existing files---------------

for i in list_1:    #clean_existing_files
  delete_html(i)
  
#------------------Requesting urls and save it to file----

for (i,j) in zip(list_1,list_2):              #uncomment after done
 a=request_category_urls(j)
 print('Rquesting Url......')
 sleep(1)
 append_value(i+'.html',a)

# #------------------data-cleaning-operation----------
for b in list_1:
 a=open_utf(b+'.html') #picking regarded html
 a=str(a)
 pattern=re.findall(r'(?<=<p>)(.*)(?=<span class="exp-dots">)',a)
 count=0
 for i in pattern:
  #l="{line_number}: {post}\n".format(line_number=count, post=i)
  append_value('category/'+b+'.txt','\n'+i)
 
#  pattern1=pattern[0]
#  g=re.sub('(?<=<a href=\")',",",pattern1)
#  h=g.split(',')
#  for i in h:
#   if 'rel="bookmark">' in i:
#     pattern=re.compile(r'(?<=rel="bookmark">)(.*)(?=</a></h2>)')
#     count=0
#     for match in pattern.finditer(i):
#      c=match.group(1) #c contain some special strings to remove this i used if 
#      if len(c) > 100:
#       print('')
#      else:
#       count=count+1
#       #l="{line_number}: {post}\n".format(line_number=count, post=c)
#       append_value('category/'+b+'.txt',c)

# # #------------------append_line_number-------------------

# for i in list_1:
#  j='category/'+i+'.txt'
#  os.system("echo '1,$n' | ed -s ${j} > ${j}")

#------------------cleaning_workspace--------------------

sleep(1)
print('cleaning_workspace..........')
for i in list_1:    #clean_existing_files
  delete_html(i)
