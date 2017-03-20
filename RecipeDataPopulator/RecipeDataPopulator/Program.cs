using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace RecipeDataPopulator
{
    class Program
    {
        static HttpClient _client = new HttpClient();
        static string _getPath = "recipes/{id}/information?includeNutrition=false";
        static string _rawDataPath = "raw_recipes.txt";
        static string _sqlInsertsPath = "insert_recipes.txt";
        static int _maxId = 500000;

        static void Main(string[] args)
        {
            InitClient();
            Task<Recipe> task = GetRecipeAsync(MakeGetRecipePath(479101));
            task.Wait();
            Recipe recipe = task.Result;

            Console.ReadKey();
        }

        static string ExtractRecipes(int count)
        {
            InitClient();
            Random random = new Random();
            StreamWriter sqlInsertWriter = new StreamWriter(_sqlInsertsPath, true);
            StreamWriter rawDataWriter = new StreamWriter(_rawDataPath, true);

            int recipeId = 0;
            List<int> usedIds = new List<int>();
            using (StreamReader reader = new StreamReader(_sqlInsertsPath))
            {
                Regex idRegex = new Regex("VALUES \\((\\d)+");
                while (!reader.EndOfStream)
                {
                    string line = reader.ReadLine();
                    Match match = idRegex.Match(line);
                    recipeId = Int32.Parse(match.Captures[0].Value);
                    usedIds.Add(recipeId);
                }
            }
            
            for (int i = 0; i < count; ++i)
            {
                int id = random.Next(_maxId);
                if (usedIds.Contains(id))
                    continue;

                var getRecipeTask = GetRecipeAsync(MakeGetRecipePath(id));
                getRecipeTask.Wait();
                Recipe recipe = getRecipeTask.Result;

                string insertRecipeStatement = MakeInsertStatement("Recipes",
                    recipe.Id,
                    recipe.Title,
                    "NULL",
                    recipe.Instructions,
                    "NULL",
                    recipe.Image,
                    "NULL",
                    "NULL");
                foreach (ExtendedIngredient ingredient in recipe.ExtendedIngredients)
                {

                }
            }

            sqlInsertWriter.Flush();
            sqlInsertWriter.Close();
            rawDataWriter.Flush();
            rawDataWriter.Close();
        }

        static string MakeGetRecipePath(int id)
        {
            return _getPath.Replace("{id}", id.ToString());
        }

        static string MakeInsertStatement(string table, params object[] values)
        {
            StringBuilder statement = new StringBuilder("INSERT INTO " + table + " VALUES (");
            foreach (object value in values)
            {
                if (value is string)
                    statement.AppendFormat("\"{0}\"", value.ToString());
                else
                    statement.Append(value.ToString());
            }
            statement.Append(");");

            return statement.ToString();
        }

        static void InitClient()
        {
            _client.BaseAddress = new Uri("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/");
            _client.DefaultRequestHeaders.Accept.Clear();
            _client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            _client.DefaultRequestHeaders.Add("X-Mashape-Key", "SuPrDHDXwTmshHsn88i0dJQSzz6ep1aLKZVjsndTQvVuSOADks");
        }

        static async Task<Recipe> GetRecipeAsync(string path)
        {
            Recipe recipe = null;
            HttpResponseMessage response = await _client.GetAsync(path);
            if (response.IsSuccessStatusCode)
            {
                Stream content = await response.Content.ReadAsStreamAsync();
                DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(Recipe));
                recipe = (Recipe)ser.ReadObject(content);
            }
            else
            {
                Console.WriteLine("Unsuccessful response: {0}", response.StatusCode);
            }
            return recipe;
        }
    }

    [DataContract(Name = "rootObject")]
    public class Recipe
    {
        [DataMember(Name = "vegetarian")]
        public bool Vegetarian { get; set; }
        [DataMember(Name = "vegan")]
        public bool Vegan { get; set; }
        [DataMember(Name = "glutenFree")]
        public bool GlutenFree { get; set; }
        [DataMember(Name = "dairyFree")]
        public bool DairyFree { get; set; }
        [DataMember(Name = "veryHealthy")]
        public bool VeryHealthy { get; set; }
        [DataMember(Name = "cheap")]
        public bool Cheap { get; set; }
        [DataMember(Name = "veryPopular")]
        public bool VeryPopular { get; set; }
        [DataMember(Name = "sustainable")]
        public bool Sustainable { get; set; }
        [DataMember(Name = "weightWatcherSmartPoints")]
        public int WeightWatcherSmartPoints { get; set; }
        [DataMember(Name = "gaps")]
        public string Gaps { get; set; }
        [DataMember(Name = "lowFodmap")]
        public bool LowFodmap { get; set; }
        [DataMember(Name = "ketogenic")]
        public bool Ketogenic { get; set; }
        [DataMember(Name = "whole30")]
        public bool Whole30 { get; set; }
        [DataMember(Name = "servings")]
        public int Servings { get; set; }
        [DataMember(Name = "sourceUrl")]
        public string SourceUrl { get; set; }
        [DataMember(Name = "spoonacularSourceUrl")]
        public string SpoonacularSourceUrl { get; set; }
        [DataMember(Name = "aggregateLikes")]
        public int AggregateLikes { get; set; }
        [DataMember(Name = "creditText")]
        public string CreditText { get; set; }
        [DataMember(Name = "sourceName")]
        public string SourceName { get; set; }
        [DataMember(Name = "extendedIngredients")]
        public ExtendedIngredient[] ExtendedIngredients { get; set; }
        [DataMember(Name = "id")]
        public int Id { get; set; }
        [DataMember(Name = "title")]
        public string Title { get; set; }
        [DataMember(Name = "readyInMinutes")]
        public int ReadyInMinutes { get; set; }
        [DataMember(Name = "image")]
        public string Image { get; set; }
        [DataMember(Name = "imageType")]
        public string ImageType { get; set; }
        [DataMember(Name = "instructions")]
        public string Instructions { get; set; }
    }

    [DataContract(Name = "extendedIngredient")]
    public class ExtendedIngredient
    {
        [DataMember(Name = "id")]
        public int Id { get; set; }
        [DataMember(Name = "aisle")]
        public string Aisle { get; set; }
        [DataMember(Name = "image")]
        public string Image { get; set; }
        [DataMember(Name = "name")]
        public string Name { get; set; }
        [DataMember(Name = "amount")]
        public float Amount { get; set; }
        [DataMember(Name = "unit")]
        public string Unit { get; set; }
        [DataMember(Name = "unitShort")]
        public string UnitShort { get; set; }
        [DataMember(Name = "unitLong")]
        public string UnitLong { get; set; }
        [DataMember(Name = "originalString")]
        public string OriginalString { get; set; }
        [DataMember(Name = "metaInformation")]
        public string[] MetaInformation { get; set; }
    }

}
