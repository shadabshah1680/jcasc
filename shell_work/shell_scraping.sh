>text
#!/usr/bin/bash
>updated_menu_list
>menu
>items
>commands.sh
>tex
>sorted_menu
green=`tput setaf 2`
#----------------------------------download content to be scrap-------
wget -r -l1 --no-parent -A ".html" https://mcdonalds.com.pk/our-menu/breakfast/ && cp mcdonalds.com.pk/our-menu/breakfast/* . && rm -rf mcdonalds.com.pk
curl https://mcdonalds.com.pk/index.html > new.html
#-----------------------------------clean content----------------------
echo "${green} Cleanning Data"
sleep 1
cat index.html | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | grep our-menu | sed -e '1,4d' | cut -d"/" -f 5 | sed '1,/^\s*$/d' > menu
cat index.html | grep '/product/' | grep -o -P '(?<=">).*(?=</h2>)' | sed 's/<h2 class="woocommerce-loop-product__title">//g'  >items
cat new.html |  grep product-category |  grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | cut -d"/" -f5 > unsorted_menu.ID
cat new.html |  grep product-category  | cut -d"(" -f 2 | cut -d")" -f 1 > unsorted_counts.ID
cat index.html | grep '/product/' | grep -o -P '(?<=">).*(?=</h2>)' | sed 's/<h2 class="woocommerce-loop-product__title">//g'  >items
pr -TmJS" " unsorted_menu.ID unsorted_counts.ID > merged
echo "${green} Data Cleaned"
sed -i 's/favourites/bugrers/g' merged
for  i in `cat menu`
  do 
      cat merged | grep ${i} >> sorted_menu
done
cat  sorted_menu |  cut -d" " -f2 >counts
mkdir /tmp/menu
#----------------------Operations  Contd Add .txt ext-----------------------------------
INPUT="menu"
while read -r p 
do 
b=$((b=b+1))
echo "/tmp/menu/${b}_${p}.txt" >> updated_menu_list
done < "$INPUT"
b=0
#-----------------------Operations  Contd Make ----------------------------------
echo "${green} Making Executables"
sed -i '1 i\#!/usr/bin/bash' commands.sh
count=0
var=0
INPUT="counts"
while read -r c
do
total=$((count=count+$c))

  echo "head -n+${total} items | tail -n-${c} > ">> commands.sh
done < "$INPUT"
#----------------------- Operations  Contd ------------------
pr -TmJS" "   commands.sh  updated_menu_list > merged_index_commands.sh
#----------------------Operations  Contd----------------
sh merged_index_commands.sh
#--------------------make directories------------------------------
mkdir mcdonalds
mkdir mcdonalds/tmp
mkdir mcdonalds/tmp/menu
#-------------------Append Line numbers -------------------------------------
INPUT="updated_menu_list"
var=0
while read -r n
do
 echo '1,$n' | ed -s ${n} > mcdonalds/${n}   
done < "$INPUT"
#-------------------Clean Workspace-------------------------------------
rm -rf /tmp/menu && rm items  counts  updated_menu_list  index.html  commands.sh  menu tex text unsorted_counts.ID unsorted_menu.ID sorted_menu new.html merged

sleep 1
echo "${green}All done scraping completed Successfully..."

