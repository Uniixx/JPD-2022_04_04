Clear-Host

function CreateUser($name) {
  $user = Get-LocalUser | Where-Object Name -eq $name;

  if (!$user) {
    $user = New-LocalUser -Name $name -FullName $name -Description "Compte pour $name";
    Write-Host "Création de l'utilisateur $name avec succès!";
  } else {
    Write-Host "Utilisateur déja éxistant!";
  }
}

CreateUser("nathan");