using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SpotThatFireDatabase.Context
{
    public class SpotThatFireContext : DbContext
    {
        public SpotThatFireContext() : base("") { }
        

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            // configures one-to-many relationship
                
            
        }
    }
}
