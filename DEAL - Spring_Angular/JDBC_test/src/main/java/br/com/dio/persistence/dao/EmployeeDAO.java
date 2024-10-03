package br.com.dio.persistence.dao;

import br.com.dio.model.entity.EmployeeEntity;
import br.com.dio.utils.ConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static java.sql.Statement.RETURN_GENERATED_KEYS;

// SEMPRE USAR PREPARED STATEMENTS
public class EmployeeDAO {

    // INSERIR EMPLOYEE  "C"
    public Optional<EmployeeEntity> insert(final EmployeeEntity entity){
        final String sql = "INSERT INTO employees (name, salary, birthday) VALUES (?, ?, ?)";

        return executeWithPstm(sql, pstm -> {

            pstm.setString(1, entity.getName());
            pstm.setBigDecimal(2, entity.getSalary());
            pstm.setDate(3, java.sql.Date.valueOf(entity.getBirthday()));
            pstm.executeUpdate();

            try(ResultSet generatedKeys= pstm.getGeneratedKeys()) {
                if(generatedKeys.next()){
                    entity.setId(generatedKeys.getLong(1));
                    return Optional.of(entity);
                }else{
                    return Optional.empty();
                }
            }

        });

    }

//        Optional<Integer> result= Optional.empty();
//
//        try(
//            var connection = ConnectionUtil.getConnection();
//
//            PreparedStatement pstm = connection.prepareStatement(sql)) {
//            pstm.setString(1, entity.getName());
//            pstm.setBigDecimal(2, entity.getSalary());
//            pstm.setDate(3, java.sql.Date.valueOf(entity.getBirthday()));
//
//            result = Optional.of(pstm.executeUpdate());
//
//            } catch (SQLException ex) {
//              throw new SQLException(" "+ex.getMessage());
//        }
//
//        return result;


    // READ ALL "R"
    public List<EmployeeEntity> findAll(){
        final String sql ="SELECT id, name, salary, birthday FROM employees";

        return executeWithPstm(sql, pstm -> {
            List<EmployeeEntity> employees = new ArrayList<>();
            try (ResultSet resultSet = pstm.executeQuery()) {
                while (resultSet.next()) {
                    var entity = new EmployeeEntity(
                            resultSet.getLong("id"),
                            resultSet.getString("name"),
                            resultSet.getBigDecimal("salary"),
                            resultSet.getDate("birthday").toLocalDate()
                    );
                    employees.add(entity);
                }
            }
            return employees;
        });

//        final List<EmployeeEntity> employees = new ArrayList<EmployeeEntity>();
//
//        try(
//                var connection= ConnectionUtil.getConnection();
//                PreparedStatement pstm = connection.prepareStatement(sql);
//                ResultSet resultSet= pstm.executeQuery()){
//
//            while (resultSet.next()){
//                    var entity = new EmployeeEntity(
//                     resultSet.getLong("id"),
//                     resultSet.getString("name"),
//                     resultSet.getBigDecimal("salary"),
//                     resultSet.getDate("birthday").toLocalDate()
//                    );
//                    employees.add(entity);
//               }
//        }catch(SQLException ex){
//            throw new SQLException(" "+ex.getMessage());
//        }
//        return employees;
    }

    //READ ONE "R"
    public Optional<EmployeeEntity> findById(final long id){
        final String sql = "SELECT id, name, salary, birthday FROM employees WHERE id=?";
        return Optional.ofNullable(executeWithPstm(sql, pstm -> {
            pstm.setLong(1, id);
            try (ResultSet resultSet = pstm.executeQuery()) {
                if (resultSet.next()) {
                    return new EmployeeEntity(
                            resultSet.getLong("id"),
                            resultSet.getString("name"),
                            resultSet.getBigDecimal("salary"),
                            resultSet.getDate("birthday").toLocalDate()
                    );
                }
                return null;
            }
        }));
    }
//        Optional<EmployeeEntity> result=Optional.empty();
//
//        try(
//                var connection = ConnectionUtil.getConnection();
//                PreparedStatement pstm = connection.prepareStatement(sql)
//        ) {
//            pstm.setLong(1,id );
//            ResultSet resultSet = pstm.executeQuery();
//
//            if (resultSet.next()) {
//                EmployeeEntity entity = new EmployeeEntity(
//                        resultSet.getLong("id"),
//                        resultSet.getString("name"),
//                        resultSet.getBigDecimal("salary"),
//                        resultSet.getDate("birthday").toLocalDate()
//                );
//                result= Optional.of(entity);
//            }
//        } catch (SQLException ex) {
//            throw new SQLException(" "+ex.getMessage());
//        }
//        return result;


    // Atualiza campos não nulos apenas "U"
    public Optional<Integer> update(final Long id, EmployeeEntity entity){
        final String sql = "UPDATE employees SET  name = ?, salary = ?, birthday = ? WHERE id = ?";

        return Optional.ofNullable(executeWithPstm(sql, pstm -> {
            Optional<EmployeeEntity> existingEntityOpt = findById(id);
            if (existingEntityOpt.isPresent()) {
                EmployeeEntity existingEntity = existingEntityOpt.get();
                pstm.setString(1, entity.getName() != null ? entity.getName() : existingEntity.getName());
                pstm.setBigDecimal(2, entity.getSalary() != null ? entity.getSalary() : existingEntity.getSalary());
                pstm.setDate(3, entity.getBirthday() != null ? java.sql.Date.valueOf(entity.getBirthday()) : java.sql.Date.valueOf(existingEntity.getBirthday()));
                pstm.setLong(4, id);
                return pstm.executeUpdate();
            }
            return null;
        }));

    }

//        final Optional<EmployeeEntity> existingEntityOpt = this.findById(id);
//        Optional<Integer> result=Optional.empty();
//
//            try(
//                    var connection = ConnectionUtil.getConnection();
//                    PreparedStatement pstm = connection.prepareStatement(sql)
//            ){
//                if(existingEntityOpt.isPresent()){
//                EmployeeEntity existingEntity = existingEntityOpt.get();
//
//                pstm.setString(1, entity.getName() != null ? entity.getName() : existingEntity.getName());
//                pstm.setBigDecimal(2, entity.getSalary() != null ? entity.getSalary() : existingEntity.getSalary());
//                pstm.setDate(3, entity.getBirthday() != null ? java.sql.Date.valueOf(entity.getBirthday()) : Date.valueOf(existingEntity.getBirthday()));
//                pstm.setLong(4, id);
//
//                result = Optional.of(pstm.executeUpdate());
//                }
//            }catch(SQLException ex){
//                throw new SQLException(" "+ex.getMessage());
//            }
//
//        return result;


    // DELETA UM EMPLOYEE "D"
    public Optional<Integer> delete(final EmployeeEntity entity){
        final String sql="DELETE FROM employees WHERE id=?";

        return Optional.ofNullable(executeWithPstm(sql, pstm -> {
            pstm.setLong(1, entity.getId());
            return pstm.executeUpdate();

        }));
    }

//        Optional<Integer> result=Optional.empty();
//
//        try(var connection = ConnectionUtil.getConnection();
//            PreparedStatement pstm = connection.prepareStatement(sql)
//        ){
//            pstm.setLong(1,id);
//           result = Optional.of(pstm.executeUpdate());
//
//        }catch(SQLException ex){
//            throw new SQLException(" "+ex.getMessage());
//        }
//        return result;


    // GPT hints
    // Métodos Auxiliares
    // Para conexão e statements (pstm + connection + SQLException)

    @FunctionalInterface
    private interface Pstm<P,T>{
        T apply(P pstm) throws SQLException;
    }

    private <T> T executeWithPstm(String sql, Pstm<PreparedStatement, T> function){
        try (var connection = ConnectionUtil.getConnection();
             PreparedStatement pstm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            return function.apply(pstm);
        } catch (SQLException ex) {
                throw new RuntimeException("Error executing SQL operation: " + ex.getMessage(), ex);
        }
    }
}
