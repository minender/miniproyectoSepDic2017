package com.calclogic.dao;

import java.util.List;
import com.calclogic.entity.Usuario;

public interface UsuarioDAO 
{
    public void addUsuario(Usuario usuario);
    public void updateUsuario(Usuario usuario);
    public List<Usuario> getAllUsuarios();
    public void deleteUsuario(Integer usuarioId);
    public Usuario getUsuario(String login);
    public List<Usuario> getStudents();
}
