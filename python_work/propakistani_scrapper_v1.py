import codecs
import os #only use for file handling-|-not for adhoc shell Commands
import re
from time import sleep
import requests

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#---------------------functions------------------------|
#______________________________________________________|

def delete_html(h):
 try:                            #make sure appendable file is deleted
  if os.path.exists(h+'.html'):
   os.remove(h+'.html')
  else:
   print(h+".html is already deleted........ ") 
 except Exception as e:  
  return e

def delete_txt(h):
 try:                             #make sure appendable file is deleted
  if os.path.exists('category/'+h+'.txt'):
   os.remove('category/'+h+'.txt')
  else:
   print("File already deleted") 
 except Exception as e:
  return e


def append_value(para1,para2):   #save htmls and txt files
 with open(para1, mode="a") as file_object:
  file_object.write(para2)
  file_object.close()

def request_base_url():          #get only base file to extract catgories
 b=('https://propakistani.pk')
 c=requests.get(b)
 c=c.text 
 return c

def  request_category_urls(x):   #request category urls
 b=('https://propakistani.pk'+x)
 c = requests.get(b)
 d = c.text
 return d

def open_utf(a):
  a=codecs.open(a, mode="r" ,encoding="UTF-8")
  a=a.read()
  return a

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#------------deleting existing workspace---------------|
#______________________________________________________|

delete_html('index')             #clear existing workspace

a=request_base_url()             #get base file 
append_value('index.html',a)
sleep(2)

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#--------------------Operations-Started----------------|
#______________________________________________________|

myindexfile='index.html'
f=open_utf(myindexfile)
sleep(1)
print(type(f))
f=str(f)

list_0=[]

pattern=re.findall('(?<=<a href="https://propakistani.pk/category/)(.*)(?=/">)',f) 

list_0=pattern
print(list_0)

list_1=[]               #stored content for making dir,files & append values in it          
for index in list_0:
 a=index.replace("/","\n")
 print(a)
 list_1.append(a)

list_2=[]
for index in list_0:
 a='/category/'+index+'/'
 list_2.append(a)

print(list_2)   #['/category/sample/data/']

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#--------------------Operations------------------------|
#______________________________________________________|

main_dir='category'
try:
  if os.path.isdir(main_dir): 
   pass
  else:
     os.mkdir(main_dir)  #not found python mkdir tools except in os library to make os independent library 
except Exception as e:
     print(e)

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#----------Deleting Already existing files-------------|
#______________________________________________________|

for i in list_1:
  try:   
    delete_txt('category/'+i+'.txt')
  except:
    print(i+'.txt has been Already Deleted')

for i in list_1:    #clean_existing_files
  delete_html(i)

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#-------Request URLs and Append It into Files----------|
#______________________________________________________|

for (i,j) in zip(list_1,list_2):          
 a=request_category_urls(j)
 print('Rquesting Url......')
 sleep(2)
 append_value(i+'.html',a)
 sleep(1)

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#----------------Data Cleaning Operations--------------|
#______________________________________________________|

list_5=[]
list_6=[]
for i in range(20):
 list_5.append(i)
 a=str(i)
 list_6.append(a)

for b in list_1:
 a=open_utf(b+'.html') #picking regarded html
 a=str(a)
 pattern=re.findall(r'(?<=<p>)(.*)(?=<span class="exp-dots">)',a)
 count=0
 for (i,j,k) in zip(pattern,list_5,list_6):
  count+=1
  #l="{line_number}: {post}\n".format(line_number=count, post=i)
  append_value('category/'+b+'.txt','\n'+k+': '+i)

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#--------------Cleaning Workspace----------------------|
#______________________________________________________|

sleep(1)
print('cleaning_workspace..........')
for i in list_1:    #clean_existing_files
  delete_html(i)
('category/'+b+'.txt','\n'+i)

#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^|
#--------------Cleaning Workspace----------------------|
#______________________________________________________|

sleep(1)
print('cleaning_workspace..........')
delete_html('index')

for i in list_1:    #clean_existing_files
  delete_html(i)
