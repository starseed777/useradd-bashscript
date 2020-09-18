#!/bin/bash
 
while read -r line; 
do 

	USERNAME=$line
	PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c12)
	
	sudo useradd -m $USERNAME

	echo $USERNAME:$PASSWORD | sudo chpasswd

	echo "$USERNAME has been sucessfully added to the system!"

	sudo cp company_policy.txt /home/$USERNAME/

	touch usercredentials.txt

	echo "Login credentials: $USERNAME:$PASSWORD" >> usercredentials.txt 

	mail -A usercredentials.txt -s "Login credentials" "$USERNAME@exampledomain.com" < /dev/null && \
    
	echo "Email has been sucessfully sent" && \

    echo "Deleting credentials file now" && \

    rm -rf usercredentials.txt






done < users.txt   
