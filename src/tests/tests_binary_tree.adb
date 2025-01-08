with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Binary_Tree;

procedure Tests_Binary_Tree is

  package Char_Tree is
	  new Binary_Tree (T_Data => Character);
	use Char_Tree;

  Tree : T_Tree;

begin
  Init (Tree, 'f');
  SetLeft (Tree, 'l');
  SetRight (Tree, 'r');
end Tests_Binary_Tree;
