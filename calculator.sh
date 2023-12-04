#!/bin/bash


echo "select option (a) for addition"
echo "select option (b) for subtraction"
echo "select option (c) for multiplication"
echo "select option (d) for division"
echo "select option (e) to quit"


read input

addition(){
        read -p "enter the 1st number" n1
        read -p "enter the 2nd number" n2
        let s=$n1+$n2
        echo "sum of $n1 and $n2 is $s"
}

subtraction(){
        read -p "enter the 1st number" n1
        read -p "enter the 2nd number" n2
        let s=$n1-$n2
        echo "difference of $n1 and $n2 is $s"
}

multiplication(){
        read -p "enter the 1st number" n1
        read -p "enter the 2nd number" n2
        let s=$n1*$n2
        echo "product of $n1 and $n2 is $s"
}

division(){
        read -p "enter the 1st number" n1
        read -p "enter the 2nd number" n2
        let s=$n1/$n2
        echo "division of $n1 and $n2 is $s"
}

case $input in
        a)addition;;
	b)subtraction;;
	c)multiplication;;
	d)division;;
	e)exit;;
esac
