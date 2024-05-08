find_sln_file() {
    local sln_file=$(find . -maxdepth 1 -type f -name "*.sln" -print -quit)

    if [ -z "$sln_file" ]; then
        echo "No solution file found in this directory."
        exit 1
    fi

    echo "$sln_file"
}

add_projects_to_solution() {
    local sln_file=$1

    while IFS= read -r -d '' file; do
        dotnet sln "$sln_file" add "$file"
    done < <(find . -type f -name "*.csproj" -print0)
}



reset=false

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -n|--name)
        sln_name="$2"
        shift
        shift
        ;;
        -r|--reset)
        reset=true
        shift
        ;;
        *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done


if [ $reset = true ]; then
    sln_file=$(find_sln_file)
    
    sln_name=$(basename "$sln_file")
    sln_name="${sln_name%.sln}"

    rm "$sln_file"
    dotnet new sln -n "$sln_name"
elif [ -n "$sln_name" ]; then

    dotnet new sln -n "$sln_name"
    sln_file="$sln_name.sln"
else
    sln_file=$(find_sln_file)
fi

add_projects_to_solution "$sln_file"
