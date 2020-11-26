code --user-data-dir /data
code_pids=$(pidof code)
array_of_code_pids=($code_pids)

min=${array_of_code_pids[0]}
max=${array_of_code_pids[0]}

for i in ${array_of_code_pids[*]}; do

  # Update max if applicable
  if [[ "$i" -gt "$max" ]]; then
    max="$i"
  fi

  # Update min if applicable
  if [[ "$i" -lt "$min" ]]; then
    min="$i"
  fi
done

 while ps -p $min > /dev/null
 do
    sleep 5
 done
