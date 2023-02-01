echo "variable a is " $1
echo "variable b is " $2
echo "variable c is " $3

if [[ $2 < $3 && $2 < $1 ]]; then echo $2 "is the smallest" 
fi
if [[ $3 < $2 && $3 < $1 ]]; then echo $3 "is the smallest" 
fi
if [[ $1 < $3 && $1 < $2 ]]; then echo $1 "is the smallest" 
fi



