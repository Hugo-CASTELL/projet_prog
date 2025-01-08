generic
	type T_Data is private;

package Binary_Tree is

  -- #--------#
  -- # T_Tree #
  -- #--------#

  -- ### Type and Exceptions ###

	type T_Tree is limited private;

	Data_Free_By_Third_Party_Exception: Exception;	

  -- ### Constructor ###

	-- Initialiser un Tree Tree. L'Tree est vide.
	procedure Init(Tree: out T_Tree; Data: in T_Data) with
		Post => (IsBranchEmpty(Tree, True) and IsBranchEmpty(Tree, False)) and (IsEmpty(Tree) = False);

  -- ### Getters / Setters ###

	-- Returns the value of the binary tree's branch
	function GetLeft (Tree: in T_Tree) return T_Tree; 

	-- Change the value of the binary tree's left branch
	procedure SetLeft (Tree: in out T_Tree; Data: in T_Data) with
		Post => (IsBranchEmpty(Tree, True) /= IsBranchEmpty(Tree, True)'Old and GetSize (Tree) /= GetSize (Tree)'Old) and
		        (IsBranchEmpty(Tree, True)  = IsBranchEmpty(Tree, True)'Old and GetSize (Tree)  = GetSize (Tree)'Old);

	-- Clears the value of the binary tree's left branch
	procedure ClearLeft (Tree: in out T_Tree) with
		Post => (IsBranchEmpty(Tree, True) and GetSize (Tree) /= GetSize (Tree)'Old);

	-- Returns the value of the binary tree's right branch
	function GetRight (Tree: in T_Tree) return T_Tree; 

	-- Change the value of the binary tree's right branch
	procedure SetRight (Tree: in out T_Tree; Data: in T_Data) with
		Post => (IsBranchEmpty(Tree, False) /= IsBranchEmpty(Tree, False)'Old and GetSize (Tree) /= GetSize (Tree)'Old) and
		        (IsBranchEmpty(Tree, False)  = IsBranchEmpty(Tree, False)'Old and GetSize (Tree)  = GetSize (Tree)'Old);

	-- Clears the value of the binary tree's right branch
	procedure ClearRight (Tree: in out T_Tree) with
		Post => (IsBranchEmpty(Tree, False) and GetSize (Tree) /= GetSize (Tree)'Old);

	-- Returns the data of the binary tree
	function GetData (Tree: in T_Tree) return T_Data; 

  -- ### Functions ###

	-- Determine if the tree's branch is empty
	function IsBranchEmpty (Tree: in T_Tree; left: in Boolean) return Boolean;

	-- Determine if the tree is a leaf
	function IsLeaf (Tree: in T_Tree) return Boolean;

	-- Determine if the tree has a data
	function IsEmpty (Tree: in T_Tree) return Boolean;

	-- Returns the size of the tree
	function GetSize (Tree: in T_Tree) return Integer with
		Post => GetSize'Result >= 0 and
            (GetSize'Result = 0) = (IsBranchEmpty(Tree, True) and IsBranchEmpty(Tree, False));

	-- Print the binary tree in the console
	procedure Print (Tree: in T_Tree);

	-- Afficher un Tree Tree (en faisant apparaître la strucre grâce à une
	-- indendation et un signe '<', '>', '/' pour indiquer la sous-arbre
	-- gauche, '>' pour un sous arbre droit et '/' pour la racine)
	-- Exemple:
	--
	--  / Cle1: Valeur1
	--      < Cle2: Valeur2
	--          > Cle3: Valeur3
	--      > Cle4: Valeur 4
	--          < Cle5: Valeur 5

private

  -- #--------#
  -- # T_Node #
  -- #--------#

	type T_Node;
	type T_Tree is access T_Node;
	type T_Node is
		record
			Data: T_Data;
			Left: T_Tree;
			Right: T_Tree;
		end record;

end Binary_Tree;
