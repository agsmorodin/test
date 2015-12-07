#!/bin/bash 
set -e

function execute_role {
	    echo $dir
            #echo ${changed_file:0:$size}
            echo "!!!!!!!"
            echo "Trigger role"
            cat role_template  | sed  "s/role_name/${dir::-1}/g" > ${dir::-1}_template
            echo "pipac deploy  --gocd-url gocd.backbase.dev:8153 --gocd-auth  -i  --yaml ${dir::-1}_template"
            echo "curl  -u gocd:b4ckb4s3-g0cd -d ""   http://gocd.backbase.dev:8153/go/api/pipelines/${dir::-1}/schedule"
}


from_revision=$1
to_revision=$2
force=$3


if [ -z ${from_revision} ]; then
  echo please specify from_revision
  echo
  exit 0
fi

if [ -z ${to_revision} ]; then
  echo please specify to_revision
  echo
  exit 0
fi





changed_files=( $(git diff     --name-only  "${from_revision}~1"   $to_revision) )

#for i in "${changed_files[@]}"
#do
#   echo "*"
#done
echo "************"

all_dirs=( $(ls -d */) )
for dir in "${all_dirs[@]}"
do
  if [ -f ${dir}.kitchen-ec2.yml ];
   then
   #echo $dir
   size=${#dir} 
   #echo $size 
   if [ -n "$force" ] 
   then
       echo "using force"
       execute_role     
   else
       echo "comparing"  
       for changed_file in "${changed_files[@]}"
       do
          if [ "$dir" == "${changed_file:0:$size}" ];
   	  then
		execute_role
		break
          fi
       done
   fi
  fi
done

