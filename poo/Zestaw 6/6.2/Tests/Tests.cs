using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace _6._2
{
    [TestClass]
    public class InterpreterTests
    {
        private Context _context;

        [TestInitialize]
        public void init()
        {
            _context = new Context();
        }

        [TestMethod]
        public void TestContextAssigningValue()
        {
            _context.setValue("x", true);
            Assert.AreEqual(_context.getValue("x"), true);
        }

        [TestMethod]
        public void TestConstExpression()
        {
            AbstractExpression expr = new ConstExpression(true);

            Assert.AreEqual(expr.interpret(_context), true);
        }

        [TestMethod]
        public void TestVariableExpression()
        {
            _context.setValue("x", true);

            AbstractExpression expr = new VariableExpression("x");

            Assert.AreEqual(expr.interpret(_context), true);
        }

        [TestMethod]
        public void TestNegationExpression()
        {
            AbstractExpression expr1 = new ConstExpression(true);
            AbstractExpression expr2 = new NegationExpression(expr1);

            Assert.AreEqual(expr2.interpret(_context), false);
        }

        [TestMethod]
        public void TestConjunctionTrueExpression()
        {
            AbstractExpression expr1 = new ConstExpression(true);
            AbstractExpression expr2 = new ConstExpression(true);
            AbstractExpression expr3 = new ConjunctionExpression(expr1, expr2);

            Assert.AreEqual(expr3.interpret(_context), true);
        }

        [TestMethod]
        public void TestConjunctionFalseExpression()
        {
            AbstractExpression expr1 = new ConstExpression(true);
            AbstractExpression expr2 = new ConstExpression(false);
            AbstractExpression expr3 = new ConjunctionExpression(expr1, expr2);

            Assert.AreEqual(expr3.interpret(_context), false);
        }

        [TestMethod]
        public void TestDisjunctionTrueExpression()
        {
            AbstractExpression expr1 = new ConstExpression(true);
            AbstractExpression expr2 = new ConstExpression(false);
            AbstractExpression expr3 = new DisjunctionExpression(expr1, expr2);

            Assert.AreEqual(expr3.interpret(_context), true);
        }

        [TestMethod]
        public void TestDisjunctionFalseExpression()
        {
            AbstractExpression expr1 = new ConstExpression(false);
            AbstractExpression expr2 = new ConstExpression(false);
            AbstractExpression expr3 = new ConjunctionExpression(expr1, expr2);

            Assert.AreEqual(expr3.interpret(_context), false);
        }

        [TestMethod]
        public void TestComplexExpression()
        {
            _context.setValue("x", true);
            _context.setValue("y", false);

            // (x v y ) n true
            AbstractExpression xExpr = new VariableExpression("x");
            AbstractExpression yExpr = new VariableExpression("y");
            AbstractExpression trueExpr = new ConstExpression(true);

            AbstractExpression orExpr = new DisjunctionExpression(xExpr, yExpr);
            AbstractExpression andExpr = new ConjunctionExpression(orExpr, trueExpr);

            Assert.AreEqual(andExpr.interpret(_context), true);
        }
    }
}
