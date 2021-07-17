# select result in Yes No Cancel
# do
#     echo $result && read -p '' && break;
# done

echo "Discard 'lock' file edits ?"
select result in Yes No
do
    if [ $result = "Yes" ]; then
        # git reset HEAD -- *lock* && git restore *lock*;
        echo git reset HEAD -- *lock* && echo git restore *lock*;
    fi && break;
done && read -p '' && exit;
