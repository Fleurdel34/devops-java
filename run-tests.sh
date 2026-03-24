echo "Clean previous artifacts"

rm -rf test-results/
rm -f *.log
rm -rf dist/

#Angular
if [ -f "package.json" ]; then
    echo "Angular project"

    echo "Run tests"
    npm test
    status=$?

    if [ $status -ne 0 ]; then
        echo "Tests failed"
        exit 1
    fi

    echo "Tests successfully"
    echo "Report in test-results"
    exit 0
fi

#Java
if [ -f "build.gradle" ]; then
    echo "Java project"

    echo "Run tests"
    ./gradlew clean test
    status=$?

    if [ $status -ne 0 ]; then
        echo "Tests failed"
        exit 1
    fi

    echo "Copy JUnit reports"
    mkdir -p test-results
    cp -r build/test-results/test/* test-results/

    echo "Tests successfully"
    echo "Report in test-results"
    exit 0
fi

#absence of a project
if [ ! -f "package.json" ] && [ ! -f "build.gradle" ]; then
  echo "No Angular or Java project found"
  exit 1
fi

exit 0