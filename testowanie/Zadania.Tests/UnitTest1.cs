
using System;
using System.Collections.Generic;
using NUnit.Framework;
using Zadania;

namespace Tests
{
    [TestFixture]
    public class Tests
    {
        private Zadanie1 _zadanie1;

        [SetUp]
        public void Setup()
        {
            _zadanie1 = new Zadanie1();
        }

        [Test]
        public void ShouldDelete()
        {
            var list = new List<string>(new string[] {"mama", "test", "tata"});
            var item = "test";
            var ans = new string[] {"mama", "tata"};

            var resoult = _zadanie1.deleteFromList(item, list);
            
            Assert.AreEqual(resoult, ans);
        }

        [Test]
        public void FirstArgumentNull(){
            var list = new List<string>(new string[] {"mama", "test", "tata"});
            
            Assert.That(() => _zadanie1.deleteFromList(null, list), 
            Throws.Exception.TypeOf<ArgumentNullException>()
            .With.Message.Contains("Argument jest null"));

        }

        [Test]
        public void EmptyList(){
            var list = new List<string>();
            var item = "test";
            var ans = new string[] {};

            var resoult = _zadanie1.deleteFromList(item, list);

            Assert.AreEqual(ans, resoult);

        }

        [Test]
        public void ItemNull()
        {
            var list = new List<string>(new string[] {"mama", "test", "tata"});
            var item = "";
            var ans = new string[] {"mama","test", "tata"};

            var resoult = _zadanie1.deleteFromList(item, list);
            
            Assert.AreEqual(resoult, ans);
        }

    }
}