import codecs
import os #only use for file handling-|-not for adhoc shell Commands
import re
#from time import #sleep
import requests
#---------------------functions------------------------|
#______________________________________________________|
rep={"rel=\"bookmark\">": "", "</a>":"" }
def replace_all(text, dic):
    for i, j in dic.items():
        text = text.replace(i, j)
    return text

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

#------------deleting existing workspace---------------|
#______________________________________________________|

print('Scraping Process Started.....')
delete_html('index')             #clear existing workspace

a=request_base_url()             #get base file 
append_value('index.html',a)
#sleep(2)

#--------------------Operations-Started----------------|
#______________________________________________________|

myindexfile='index.html'
f=open_utf(myindexfile)
#sleep(1)
print(type(f))
f=str(f)

list_0=[]

pattern=re.findall('(?<=<a href="https://propakistani.pk/category/)(.*)(?=/">)',f) 

list_0=pattern
print(list_0)
# list _0=   output:['tech-and-telecom', 'automobile', 'business','others/aviation', 'sports']

list_1=[]
for i in list_0:    #remove uncertainity if any subcategory comes
 if '/' in i:
  a=i.split('/')[0]
  b=i.split('/')[1]
  list_1.append(b)
  list_1.append(a)
 else:
  list_1.append(i)

print(list_1)
# list _1=   output:['tech-and-telecom', 'automobile', 'business', 'others','aviation', 'sports']

list_2=[]
for index in list_0:
 list_2.append('/category/'+index+'/')
 if '/' in index:
  a=index.split('/')[0]
  list_2.append('/category/'+a+'/')

print(list_2)
#output: ['/category/tech-and-telecom/', '/category/automobile/', '/category/business/', '/category/others/aviation/', 'others', '/category/sports/']

#--------------------Operations------------------------|
#______________________________________________________|

main_dir='category'
try:
  if os.path.isdir(main_dir): 
   pass
  else:
     os.mkdir(main_dir)  #not found python mkdir tools except in os library to make os independent library 
except Exception as e:
     print(e+'Direcotry Already Exist')

#----------Deleting Already existing files-------------|
#______________________________________________________|

for i in list_1:
  try:   
    delete_txt(i)
  except:
    print(i+'.txt has been Already Deleted')

for i in list_1:    #clean_existing_files
  delete_html(i)

#-------Request URLs and Append It into Files----------|
#______________________________________________________|

for (i,j) in zip(list_1,list_2):          
 a=request_category_urls(j)
 print('Rquesting Url......and...saved....'+i+'.html')
 #sleep(2)
 append_value(i+'.html',a)
 #sleep(1)

#----------------Data Cleaning Operations--------------|
#______________________________________________________|
print('Data Cleaining Operation Started')

list_6=[]
for i in range(20):
 i+=1 
 a=str(i)
 list_6.append(a)
 list_6.append('--')
print(list_1)
list_7=[]
for b in list_1:
 print('Data cleaned for '+b+'.html')
 a=open_utf(b+'.html') #picking regarded html
 a=str(a)
 pattern=re.findall(r'(?<=rel="bookmark">)(.*)(?=</a>)',a)
 for (i,k) in zip(pattern,list_6):
  removing_special= re.sub('[^a-zA-Z0-9 \n\.]', '', i)
  append_value('category/'+b+'.txt','\n'+k+': '+removing_special)

#--------------Cleaning Workspace----------------------|
#______________________________________________________|

#sleep(1)
print('cleaning_workspace..........')
#sleep(1)
print('cleaning_workspace..........')
delete_html('index')

for i in list_1:    #clean_existing_files
  delete_html(i)
  print('Post action: Deleting '+i+'.html')

print('Scraping Process Completed Successfully')