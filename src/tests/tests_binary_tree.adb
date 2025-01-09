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

  -- Testing initialisation
  pragma Assert(GetData(Tree) = 'f');

  -- Testing if branches are empty
  pragma Assert(IsBranchEmpty(Tree, True) = True);
  pragma Assert(IsBranchEmpty(Tree, False) = True);

  -- Testing size
  pragma Assert(GetSize(Tree) = 0);

  -- Set values to branches
  SetLeft (Tree, 'l');
  SetRight (Tree, 'r');

  -- Testing assignation of branches
  pragma Assert(GetData(GetLeft(Tree)) = 'l');
  pragma Assert(GetData(GetRight(Tree)) = 'r');

  -- Testing size with (and of) branches
  pragma Assert(GetSize(Tree) = 2);
  pragma Assert(GetSize(GetLeft(Tree)) = 0);
  pragma Assert(GetSize(GetRight(Tree)) = 0);

  -- Testing leaf detection
  pragma Assert(IsLeaf(GetLeft(Tree)) = True);
  pragma Assert(IsLeaf(GetRight(Tree)) = True);
  -- Clearing the right branch
  ClearRight(Tree);

  -- Testing clearing
  pragma Assert(IsBranchEmpty(Tree, False) = True);
  pragma Assert(GetSize(Tree) = 1);

end Tests_Binary_Tree;
