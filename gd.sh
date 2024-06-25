#! /bin/bash

# Currently we are inside `tools` directory
# Go back to `resources` directory/submodule
# To run git commands in the `resources` submodule
echo "cd ../resources"

cd ../resources

NUM_COMMIT=$(git rev-list --count HEAD)
if [[ NUM_COMMIT -gt 1 ]]
then
    FILES=$(git log --diff-filter=D --numstat --pretty='' HEAD~1..HEAD | cut -f3 | grep ".md")
else
    FILES=$(git log --diff-filter=D --numstat --pretty='' HEAD | cut -f3 | grep ".md")
fi

echo "cd ../codelabs"

# Currently we are inside `resources` directory
# Go back to `codelabs` directory/submodule
# To remove the deleted directories that is corresponded to the deleted files
cd ../codelabs

# Remove directories that is corresponded to the deleted files
for file in $FILES
do
    # extension="${filename##*.}"
    # filename="${filename%.*}"

    # remove `.md` from the name
    dirname="${file%.*}"
    echo "Removing ... $dirname"

    rm -rf $dirname
done