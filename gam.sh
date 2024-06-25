#! /bin/bash

# Currently we are inside `tools` directory
# Go back to `resources` directory/submodule
# To run git commands in the `resources` submodule
echo "cd ../resources"

cd ../resources

# Get the number of commits`
NUM_COMMIT=$(git rev-list --count HEAD)
if [[ NUM_COMMIT -gt 1 ]]
then
    FILES=$(git log --diff-filter=AM --numstat --pretty='' HEAD~1..HEAD | cut -f3 | grep ".md")
else
    FILES=$(git log --diff-filter=AM --numstat --pretty='' HEAD | cut -f3 | grep ".md")
fi

# Currently we are inside `resources` directory/submodule
# Go back to `codelabs` directory/submodule
# To generate newly added files
cd ../codelabs

# Generate Codelab websites from the added MD files
for file in $FILES
do
    echo "Exporting... ../resources/$file"
    /usr/local/bin/claat export "../resources/$file"
done