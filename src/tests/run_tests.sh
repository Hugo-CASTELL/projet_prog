# Prepare directory for running tests
echo "\nCopying Ada package specifications (.ads & .adb) from the parent directory..."
cp ../*.adb ./
cp ../*.ads ./

echo "\nCompiling Ada source files from the parent directory..."
gnatmake ../*.adb

# Prepare tests
echo "\nCompiling test file..."
gnatmake -gnata tests_binary_tree.adb

# Run tests
echo "\nRunning test files:"
./tests_binary_tree
if [ $? -eq 0 ]; then
    echo "Tests binary trees OK"
fi

# Remove all files in the current directory, but exclude tests_binary_tree.adb
echo "\nClear directory"
for file in $(ls ./ 2>/dev/null | grep -v -e "tests_binary_tree.adb" -e "run_tests.sh"); do
    rm "$file"
done

