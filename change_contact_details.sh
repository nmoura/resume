#!/bin/sh

contact_details_file="contact_details.txt"
resume_file="Nilton_Moura-Resume.tex"

parser(){
  echo $(sed -e '/./{H;$!d;}' -e 'x;/\['$1'\]/b' -e d "$contact_details_file" \
| grep -E \("^$2 ="\|"^$2="\) | cut -d '=' -f 2 | tr -d \" | tr -d \')
}

if [ "$1" == "true" ] ; then
    src="false"
    dst="true"
elif [ "$1" == "false" ] ; then
    src="true"
    dst="false"
else
    echo "invalid option"
    exit 1
fi

if [ "$(uname -s)" == "Darwin" ] ; then
    alias sed=gsed
fi

src_phone=$(parser "$src" phone)
src_email=$(parser "$src" email)
dst_phone=$(parser "$dst" phone)
dst_email=$(parser "$dst" email)

sed -i "s/$src_phone/$dst_phone/g" $resume_file
if [ "$?" != 0 ] ; then
    echo "error attempting to replace $src_phone with $dst_phone"
    exit 1
fi
sed -i "s/$src_email/$dst_email/g" $resume_file
if [ "$?" != 0 ] ; then
    echo "error attempting to replace $src_email with $dst_email"
    exit 1
fi
