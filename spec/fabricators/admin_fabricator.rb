
Fabricator(:admin) do
  email "admin@codeforamerica.org"
  password "12345678"
  password_confirmation "12345678"
end

Fabricator(:another_admin, from: :admin) do
  email "another.admin@codeforamerica.org"
end