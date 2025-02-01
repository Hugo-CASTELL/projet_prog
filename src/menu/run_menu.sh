# Prepare directory for running tests
echo "\nCopying Ada package specifications (.ads & .adb) from the parent directory..."
cp ../*.adb ./
cp ../*.ads ./

echo "\nCompiling Ada source files from the parent directory..."
gnatmake -gnat2022 ../*.adb

# Prepare tests
echo "\nCompiling menu file..."
gnatmake -gnata -gnat2022 menu.adb

# Run tests
echo "\nRunning menu"
./menu
if [ $? -eq 0 ]; then
    echo "Menu closed correctly OK"
fi

# Remove all files in the current directory, but exclude menu.adb and the script itself
echo "\nClear directory"
for file in $(ls ./ 2>/dev/null | grep -v -e "menu.adb" -e "run_menu.sh"); do
    rm "$file"
done

