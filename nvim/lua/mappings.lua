require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-----------------------------------------------------------
-- 🌲 Toggle file tree
-----------------------------------------------------------
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file tree" })

-----------------------------------------------------------
-- 🧩 Insert C++ CP template
-----------------------------------------------------------
map("n", "<leader>t", function()
  local template = [[
 #include <bits/stdc++.h>
using namespace std;

#define fastio ios::sync_with_stdio(false); cin.tie(nullptr);
#define ll long long
#define all(x) (x).begin(), (x).end()
#define endl '\n'
#define M 1000000007  


#define deb(...) logger(#__VA_ARGS__, __VA_ARGS__)
template<typename ...Args>
void logger(string vars, Args&&... values) {
    cout << vars << " = ";
    string delim = "";
    (..., (cout << delim << values, delim = ", "));
    cout<<endl;
}

void modadd(ll a,ll b){
  a=(a+b) % M;
}

void solve(){ 
  
}

int main() {
    fastio;
    
    int t = 1;
    // cin >> t;
    while (t--) {
       solve(); 
    }

    return 0;
}
  

  ]]

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
  print("✅ C++ template inserted!")
end, { noremap = true, silent = true, desc = "Insert C++ CP template" })

-----------------------------------------------------------
-- ⚙️ Compile & Run C++ (auto-delete executable after run)
-----------------------------------------------------------
map("n", "<leader>r", function()
  local filename = vim.fn.expand("%:p")

  if not filename:match("%.cpp$") and not filename:match("%.cc$") and not filename:match("%.cxx$") then
    print("❌ Not a C++ file!")
    return
  end

  local output = "a.out"
  local compile_cmd = string.format("g++ -std=c++17 -O2 -Wall \"%s\" -o \"%s\"", filename, output)

  -- Close any existing terminal
  vim.cmd("silent! bufdo if &buftype == 'terminal' | bwipeout! | endif")

  -- Compile
  local result = vim.fn.system(compile_cmd)
  if vim.v.shell_error ~= 0 then
    print("❌ Compilation failed!")
    print(result)
    return
  end

  print("✅ Compilation successful! Running (will auto-delete a.out)...")

  -- Run program & auto-delete executable afterwards
  vim.cmd("botright split")
  vim.cmd("resize 12")
  vim.cmd("terminal bash -c './" .. output .. " ; rm -f ./" .. output .. " ; exec bash'")

  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Compile & run C++ interactively (auto-clean)" })


-----------------------------------------------------------
-- 🆕 Create new file
-----------------------------------------------------------
map("n", "<leader>n", function()
  local filename = vim.fn.input("📄 New file name: ")
  if filename and filename ~= "" then
    vim.cmd("edit " .. vim.fn.fnameescape(filename))
  else
    print("⚠️ No file name entered")
  end
end, { noremap = true, silent = true, desc = "Create new file" })

-----------------------------------------------------------
-- 📋 File operations
-----------------------------------------------------------
map("n", "<leader>fa", "ggVG", { noremap = true, silent = true, desc = "Select entire file" })
map("n", "<leader>fy", "ggVG\"+y", { noremap = true, silent = true, desc = "Copy entire file" })
map("n", "<leader>fx", "ggVG\"+x", { noremap = true, silent = true, desc = "Cut entire file" })
map("n", "<leader>fd", "ggVGd", { noremap = true, silent = true, desc = "Delete entire file" })
map("n", "<leader>fv", "ggVG", { noremap = true, silent = true, desc = "Visual select entire file" })
map("t", "<Esc><Esc>", "<C-\\><C-n>:q!<CR>", { noremap = true, silent = true })

