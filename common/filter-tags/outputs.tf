
output "filter_custom" {
  description = "The full filtering pattern to add to monitors"
  value  = var.filter_use_defaults == "true" ? var.filter_defaults : 
   "${join(
     " and ", 
     list(
       join(
          " and ", 
           formatlist(
              "filter(', %s')", 
              split(
                ";", 
                 replace(
                    var.filter_custom_includes,
                    ":",
                    "', '"
                 )
              )
           )
       ), 
       join(
          " and ", 
          formatlist(
            "(not filter(', %s'))", 
            split(
              ";", 
              replace(
                var.filter_custom_excludes,
                ":",
                "', '"
                )
            )
          )
       )

     )}"
   
}   
      
local.excluding_string == "" ? "" : " excluded_tags:${local.excluding_string}"

   /*formatted_filter_custom_includes = "{${replace(var.filter_custom_includes, ":", "', '")}}"
       # "aws_state', 'stopped;aws_region', 'eu-west1" 

    list_filter_custom_includes = "{${split(";", var.formatted_filter_custom_includes)}}"
       ["aws_state', 'stopped", "aws_region', 'eu-west1"] 

     formatted_list_filter_custom_includes = "{${(formatlist("filter(', %s')", var.list_filter_custom_includes)}}"
     ["filter('aws_state', 'stopped')", "filter('aws_region', 'eu-west1')"] 
        
    formatted_filter_custom_excludes = "{${replace(var.filter_custom_excludes, ":", "', '")}}"
      "aws_state', 'stopped;aws_region', 'eu-west1" 

    list_filter_custom_excludes = "{${split(";", var.formatted_filter_custom_excludes)}}"
     ["aws_state', 'stopped", "aws_region', 'eu-west1"] 

    formatted_list_filter_custom_excludes = "{${formatlist("(not filter(', %s'))", var.list_filter_custom_excludes)}}"
     ["(not filter('aws_state', 'stopped'))", "(not filter('aws_region', 'eu-west1'))"]   */    


        
        
