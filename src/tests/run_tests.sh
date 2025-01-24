# Prepare directory for running tests
echo "\nCopying Ada package specifications (.ads & .adb) from the parent directory..."
cp ../*.adb ./
cp ../*.ads ./

echo "\nCompiling Ada source files from the parent directory..."
gnatmake -gnat2022 ../*.adb

# Prepare tests
echo "\nCompiling test file..."
gnatmake -gnata -gnat2022 tests_binary_tree.adb
gnatmake -gnata -gnat2022 tests_person.adb
gnatmake -gnata -gnat2022 tests_list.adb
gnatmake -gnata -gnat2022 tests_genealogic_tree.adb

# Run tests
echo "\nRunning test files:"
./tests_binary_tree
if [ $? -eq 0 ]; then
    echo "Tests binary trees OK"
fi
./tests_person
if [ $? -eq 0 ]; then
    echo "Tests persons OK"
fi
./tests_list
if [ $? -eq 0 ]; then
    echo "Tests lists OK"
fi
./tests_genealogic_tree
if [ $? -eq 0 ]; then
    echo "Tests genealogic trees OK"
fi

# Remove all files in the current directory, but exclude tests_binary_tree.adb
echo "\nClear directory"
for file in $(ls ./ 2>/dev/null | grep -v -e "tests_binary_tree.adb" -e "tests_genealogic_tree.adb" -e "tests_person.adb" -e "tests_list.adb" -e "run_tests.sh"); do
    rm "$file"
done

