num1=0
num2=1
read -p "Enter a  number: " len
echo "$num1"
len=$(($len-1))
for i in $( seq 1 $len)
do
temp=$num2
num2=$(($num2+$num1))
num1=$temp
echo $num1
done

