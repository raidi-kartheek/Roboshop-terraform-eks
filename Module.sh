#!/bin/bash


USER_REPO="/home/devops/Roboshop-terraform-eks"


declare -A modules
modules=(
  ["00-vpc"]="/home/devops/modules/terraform-aws-00-vpc"
  ["90-eks"]="/home/devops/modules/terraform-aws-90-eks"
  ["10-sg"]="/home/devops/modules/terraform-aws-sg"
  ["20-sg_rules"]="/home/devops/modules/terraform-aws-20-sg_rules"
#   ["40-databases"]="/home/devops/modules/terraform-aws-40-databases"
  ["70-acm"]="/home/devops/modules/terraform-aws-70-acm"
  ["80-frontend-alb"]="/home/devops/modules/terraform-aws-80-frontend-alb"

)

for module in "${!modules[@]}"
do
    MODULE_PATH=${modules[$module]}

    
    latest_version=$(git -C $MODULE_PATH describe --tags $(git -C $MODULE_PATH rev-list --tags --max-count=1))

    echo "Latest version for $module : $latest_version"

    files=$(grep -rl "terraform-aws-$module" $USER_REPO)

    for file in $files
    do
        echo "Updating $module version in $file"

        sed -i "s/version *= *.*/version = \"$latest_version\"/g" $file
    done
done

# Commit changes
cd $USER_REPO
git add .
git commit -m "Updated terraform module versions automatically"
git push origin main