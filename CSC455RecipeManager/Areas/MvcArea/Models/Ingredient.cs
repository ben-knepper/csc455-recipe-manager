using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace CSC455RecipeManager.Areas.MvcArea.Models
{
    public class Ingredient
    {
        public string IngName { get; set; }
        public string PreferredMeasure { get; set; }

    }

    
}