package com.howtodoinjava.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.howtodoinjava.entity.Usuario;

@Repository
public class UsuarioDaoImpl implements UsuarioDAO  {

	@Autowired
        private SessionFactory sessionFactory;
	
	@Override
	public void addUsuario(Usuario usuario) {
		this.sessionFactory.getCurrentSession().save(usuario);
	}
        
        @Override
        public void updateUsuario(Usuario usuario) {
		this.sessionFactory.getCurrentSession().update(usuario);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Usuario> getAllUsuarios() {
		return this.sessionFactory.getCurrentSession().createQuery("FROM Usuario").list();
	}
        
        @SuppressWarnings("unchecked")
        @Override
	public Usuario getUsuario(String login){
            return (Usuario)this.sessionFactory.getCurrentSession().get(Usuario.class,login);
        }

	@Override
	public void deleteUsuario(Integer usuarioId) {
            Usuario usuario = (Usuario) sessionFactory.getCurrentSession().load(
                            Usuario.class, usuarioId);
            if (null != usuario) {
                    this.sessionFactory.getCurrentSession().delete(usuario);
            }
	}
        
        @Override
        public List<Usuario> getStudents(){
            return this.sessionFactory.getCurrentSession().createQuery("FROM Usuario WHERE admin = 'false'").list();
        }

}
