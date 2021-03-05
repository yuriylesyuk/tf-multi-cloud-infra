#!awk -f

//

/source += +"[^"]+"/ {

  cur_dir_cmd = "dirname " FILENAME
  cur_dir_cmd | getline cur_dir
  close(cur_dir_cmd)

  match( $0, /"[^"]+"/ )
  tfi_dir = substr( $0, RSTART+1, RLENGTH-2 )
}

/# +include: / {
  tfi_file = $3

  match( $0, /^[ ]*#/ )
  tfi_indent =  substr( $0, RSTART, RLENGTH-1 )
  
  tfi_file_cmd = "cat " cur_dir "/" tfi_dir "/" tfi_file
  while( (tfi_file_cmd | getline line) > 0) {
    if( match( line, /variable +"?[^"]+"?/ ) ) {
      split( line, tokens )
      var = tokens[2]
      gsub(/"/, "", var )
      print tfi_indent var " = var." var
    }
  }
  close( tfi_file_cmd )
}
