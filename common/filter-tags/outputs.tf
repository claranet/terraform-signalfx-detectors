
output "filter_custom" {
  description = "The full filtering pattern to add to monitors"
      if var.filter_use_defaults = "true"  
      value  = var.filter_defaults
    else
      
    formatted_filter_custom_includes = replace(var.filter_custom_includes, ":", "', '"),
      /* # "aws_state', 'stopped;aws_region', 'eu-west1" */

    list_filter_custom_includes = split(";", var.formatted_filter_custom_includes),
    /* ["aws_state', 'stopped", "aws_region', 'eu-west1"] */

    formatted_list_filter_custom_includes = formatlist("filter(', %s')", var.list_filter_custom_includes),
    /* ["filter('aws_state', 'stopped')", "filter('aws_region', 'eu-west1')"] */
        
    formatted_filter_custom_excludes = replace(var.filter_custom_excludes, ":", "', '"),
    /*  "aws_state', 'stopped;aws_region', 'eu-west1" */

    list_filter_custom_excludes = split(";", var.formatted_filter_custom_excludes),
    /* ["aws_state', 'stopped", "aws_region', 'eu-west1"] */

    formatted_list_filter_custom_excludes = formatlist("(not filter(', %s'))", var.list_filter_custom_excludes),
    /* ["(not filter('aws_state', 'stopped'))", "(not filter('aws_region', 'eu-west1'))"]   */    
    
   custum_filter = join(" and ", list(join(" and ", var.formatted_list_filter_custom_includes) , join(" and ", var.formatted_list_filter_custom_excludes)),
   
         
        value = var.custom_filter
      
   }  

  


        
        
