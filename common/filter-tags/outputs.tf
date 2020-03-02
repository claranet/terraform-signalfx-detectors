output "filter_custom" {
  description = "The full filtering pattern to add to monitors"
  value  = "${var.filter_use_defaults == "true" ? var.filter_defaults : 
    "${var.filter_custom_includes == "" ? join(
          " and ", 
          formatlist(
            "(not filter('%s'))", 
            split(
              ";", 
              replace(
                replace(
                   var.filter_custom_excludes,
                   ":",
                   "', '"
                ),
                " ",
                ""
              )
            )
          )
        )
      : 
      "${var.filter_custom_excludes == "" ? join(
            " and ", 
             formatlist(
               "(not filter('%s'))", 
               split(
                 ";", 
                 replace(
                     replace(
                       var.filter_custom_includes,
                       ":",
                       "', '"
                     ),
                     " ",
                     ""
                   )
               )
             )
          )
        :
        join(
          " and ", 
          list(
             join(
               " and ", 
               formatlist(
                 "filter('%s')", 
                  split(
                    ";", 
                    replace(
                     replace(
                       var.filter_custom_includes,
                       ":",
                       "', '"
                     ),
                     " ",
                     ""
                   )
                  )
               )
             ), 
             join(
               " and ", 
               formatlist(
                 "(not filter('%s'))", 
                 split(
                   ";", 
                   replace(
                     replace(
                       var.filter_custom_excludes,
                       ":",
                       "', '"
                     ),
                     " ",
                     ""
                   )
                 )
               )
             )
          )
      )}"
  }"
}"
}  
